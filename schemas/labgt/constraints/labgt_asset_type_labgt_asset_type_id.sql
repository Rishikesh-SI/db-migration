-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_asset_type labgt_asset_type_id
-- Type: CONSTRAINT

-- Name: labgt_asset_type labgt_asset_type_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_asset_type
    ADD CONSTRAINT labgt_asset_type_id PRIMARY KEY (asset_type_id);


--
