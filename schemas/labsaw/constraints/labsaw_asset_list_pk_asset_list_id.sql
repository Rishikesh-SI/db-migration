-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_asset_list pk_asset_list_id
-- Type: CONSTRAINT

-- Name: labsaw_asset_list pk_asset_list_id; Type: CONSTRAINT; Schema: labsaw; Owner: -
--

ALTER TABLE ONLY labsaw.labsaw_asset_list
    ADD CONSTRAINT pk_asset_list_id PRIMARY KEY (asset_list_id) INCLUDE (asset_id, asset_type_id);


--
