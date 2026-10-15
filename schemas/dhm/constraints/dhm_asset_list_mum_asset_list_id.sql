-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_asset_list mum_asset_list_id
-- Type: CONSTRAINT

-- Name: dhm_asset_list mum_asset_list_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_asset_list
    ADD CONSTRAINT mum_asset_list_id PRIMARY KEY (asset_list_id);


--
