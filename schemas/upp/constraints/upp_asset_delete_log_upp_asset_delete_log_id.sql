-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_asset_delete_log upp_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: upp_asset_delete_log upp_asset_delete_log_id; Type: CONSTRAINT; Schema: upp; Owner: -
--

ALTER TABLE ONLY upp.upp_asset_delete_log
    ADD CONSTRAINT upp_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
