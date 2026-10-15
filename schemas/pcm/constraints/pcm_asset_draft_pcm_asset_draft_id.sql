-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_asset_draft pcm_asset_draft_id
-- Type: CONSTRAINT

-- Name: pcm_asset_draft pcm_asset_draft_id; Type: CONSTRAINT; Schema: pcm; Owner: -
--

ALTER TABLE ONLY pcm.pcm_asset_draft
    ADD CONSTRAINT pcm_asset_draft_id PRIMARY KEY (asset_draft_id);


--
