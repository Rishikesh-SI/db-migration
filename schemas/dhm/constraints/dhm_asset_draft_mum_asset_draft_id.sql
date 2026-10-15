-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_draft mum_asset_draft_id
-- Type: CONSTRAINT

-- Name: dhm_asset_draft mum_asset_draft_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_draft
    ADD CONSTRAINT mum_asset_draft_id PRIMARY KEY (asset_draft_id);


--
