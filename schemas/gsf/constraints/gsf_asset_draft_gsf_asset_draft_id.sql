-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: gsf_asset_draft gsf_asset_draft_id
-- Type: CONSTRAINT

-- Name: gsf_asset_draft gsf_asset_draft_id; Type: CONSTRAINT; Schema: gsf; Owner: -
--

ALTER TABLE ONLY gsf.gsf_asset_draft
    ADD CONSTRAINT gsf_asset_draft_id PRIMARY KEY (asset_draft_id);


--
