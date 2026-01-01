-- Represents a single IOC (Indicator of Compromise) lookup made by the system.
-- Stores UUIDs for IOCQuery,Type of IOC,threats core, and verdict after analysis.

CREATE TABLE IF NOT EXISTS public.ioc_query (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- The IOC value (IP, domain, URL, or hash)
    ioc TEXT NOT NULL,
    
    -- Type of IOC: 'ip', 'domain', 'url', or 'hash'
    type VARCHAR(10) NOT NULL CHECK (type IN ('ip', 'domain', 'url', 'hash')),
    
    -- Calculated threat score (0-100)
    score NUMERIC(5, 2),
    
    -- Final verdict: 'benign', 'suspicious', or 'malicious'
    verdict VARCHAR(20) NOT NULL CHECK (verdict IN ('benign', 'suspicious', 'malicious')),
    
    -- Timestamp fields
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Add comments to the table
COMMENT ON TABLE public.ioc_query IS 'Stores IOC (Indicator of Compromise) queries for threat intelligence';
COMMENT ON COLUMN public.ioc_query.id IS 'Unique identifier (UUID)';
COMMENT ON COLUMN public.ioc_query.ioc IS 'The IOC value: IP address, domain name, URL, or file hash';
COMMENT ON COLUMN public.ioc_query.type IS 'Type of IOC indicator';
COMMENT ON COLUMN public.ioc_query.score IS 'Calculated threat score (0-100 scale)';
COMMENT ON COLUMN public.ioc_query.verdict IS 'Final verdict after analysis';
COMMENT ON COLUMN public.ioc_query.created_at IS 'Timestamp when the query was created';

-- Create indexes for frequently queried fields
CREATE INDEX IF NOT EXISTS idx_ioc_query_ioc ON public.ioc_query (ioc);
CREATE INDEX IF NOT EXISTS idx_ioc_query_type ON public.ioc_query (type);
CREATE INDEX IF NOT EXISTS idx_ioc_query_verdict ON public.ioc_query (verdict);
CREATE INDEX IF NOT EXISTS idx_ioc_query_created_at ON public.ioc_query (created_at DESC);


