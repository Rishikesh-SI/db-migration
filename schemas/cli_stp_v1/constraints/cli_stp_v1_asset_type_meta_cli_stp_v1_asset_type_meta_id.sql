-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_asset_type_meta cli_stp_v1_asset_type_meta_id
-- Type: CONSTRAINT

-- Name: cli_stp_v1_asset_type_meta cli_stp_v1_asset_type_meta_id; Type: CONSTRAINT; Schema: cli_stp_v1; Owner: -
--

ALTER TABLE ONLY cli_stp_v1.cli_stp_v1_asset_type_meta
    ADD CONSTRAINT cli_stp_v1_asset_type_meta_id PRIMARY KEY (asset_type_meta_id);


--
