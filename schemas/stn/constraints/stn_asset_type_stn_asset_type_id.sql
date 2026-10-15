-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_asset_type stn_asset_type_id
-- Type: CONSTRAINT

-- Name: stn_asset_type stn_asset_type_id; Type: CONSTRAINT; Schema: stn; Owner: -
--

ALTER TABLE ONLY stn.stn_asset_type
    ADD CONSTRAINT stn_asset_type_id PRIMARY KEY (asset_type_id);


--
