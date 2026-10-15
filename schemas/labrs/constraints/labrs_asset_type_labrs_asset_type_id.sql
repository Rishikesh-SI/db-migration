-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_asset_type labrs_asset_type_id
-- Type: CONSTRAINT

-- Name: labrs_asset_type labrs_asset_type_id; Type: CONSTRAINT; Schema: labrs; Owner: -
--

ALTER TABLE ONLY labrs.labrs_asset_type
    ADD CONSTRAINT labrs_asset_type_id PRIMARY KEY (asset_type_id);


--
