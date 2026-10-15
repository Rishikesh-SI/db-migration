-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_asset_list labbr_asset_list_id
-- Type: CONSTRAINT

-- Name: labbr_asset_list labbr_asset_list_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_asset_list
    ADD CONSTRAINT labbr_asset_list_id PRIMARY KEY (asset_list_id);


--
