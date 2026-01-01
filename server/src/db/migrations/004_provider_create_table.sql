-- Stores responses from threat intelligence providers (e.g., VirusTotal)
-- for specific IOC queries. Each query can have multiple provider results.

CREATE TABLE IF NOT EXISTS public.provider_result (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- References ioc_query.id (foreign key relationship)
    query_id UUID NOT NULL,
    
    -- Name of the threat intelligence provider (e.g., 'virus_total', 'abuseipdb')
    provider_name VARCHAR(100) NOT NULL,
    
    -- Short processed result from the provider
    result TEXT NOT NULL,
    
    
    -- Timestamp fields
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    
    -- Foreign key constraint with cascade delete
    CONSTRAINT fk_provider_result_query FOREIGN KEY (query_id)
        REFERENCES public.ioc_query(id) ON DELETE CASCADE
);

COMMENT ON TABLE public.provider_result IS 'Stores threat intelligence provider responses for IOC queries';
COMMENT ON COLUMN public.provider_result.id IS 'Unique identifier (UUID)';
COMMENT ON COLUMN public.provider_result.query_id IS 'Foreign key reference to ioc_query';
COMMENT ON COLUMN public.provider_result.provider_name IS 'Name of the threat intelligence provider';
COMMENT ON COLUMN public.provider_result.result IS 'Short processed result from the provider';
COMMENT ON COLUMN public.provider_result.created_at IS 'Timestamp when the result was saved';

-- Create indexes for foreign key and frequently queried fields
CREATE INDEX IF NOT EXISTS idx_provider_result_query_id ON public.provider_result (query_id);
CREATE INDEX IF NOT EXISTS idx_provider_result_provider_name ON public.provider_result (provider_name);
CREATE INDEX IF NOT EXISTS idx_provider_result_created_at ON public.provider_result (created_at DESC);


