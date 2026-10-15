-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_asset_type_meta labdsg_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: labdsg_asset_type_meta labdsg_asset_type_meta_id; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_asset_type_meta
    ADD CONSTRAINT labdsg_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
