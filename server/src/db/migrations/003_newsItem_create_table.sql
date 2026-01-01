-- Represents cybersecurity news articles that may contain IOCs and threat information.
CREATE TABLE IF NOT EXISTS public.news_item (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    
    -- Article title
    title TEXT NOT NULL,
    
    -- Short summary of the article 
    summary TEXT,
    
    -- Original article URL
    link TEXT NOT NULL UNIQUE,
    
    -- When the article was originally published 
    published_at TIMESTAMPTZ,
    
    -- IOCs extracted from the article stored as JSON array of strings
    extracted_iocs JSONB DEFAULT '[]'::jsonb,
    
    -- Timestamp fields
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

COMMENT ON TABLE public.news_item IS 'Stores cybersecurity news articles with extracted IOC indicators';
COMMENT ON COLUMN public.news_item.id IS 'Unique identifier (UUID)';
COMMENT ON COLUMN public.news_item.title IS 'Article title';
COMMENT ON COLUMN public.news_item.summary IS 'Short summary of the article content';
COMMENT ON COLUMN public.news_item.link IS 'Original article URL (must be unique)';
COMMENT ON COLUMN public.news_item.published_at IS 'Original publication timestamp of the article';
COMMENT ON COLUMN public.news_item.extracted_iocs IS 'Array of IOC indicators extracted from the article (JSON format)';
COMMENT ON COLUMN public.news_item.created_at IS 'Timestamp when this record was created in the database';

-- Create indexes for frequently queried fields
CREATE INDEX IF NOT EXISTS idx_news_item_title ON public.news_item USING GIN (to_tsvector('english', title));
CREATE INDEX IF NOT EXISTS idx_news_item_published_at ON public.news_item (published_at DESC);
CREATE INDEX IF NOT EXISTS idx_news_item_created_at ON public.news_item (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_news_item_extracted_iocs ON public.news_item USING GIN (extracted_iocs);
