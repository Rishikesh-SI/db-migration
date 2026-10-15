-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_cms_download_config labgt_cms_download_config_module_name_key
-- Type: CONSTRAINT

-- Name: labgt_cms_download_config labgt_cms_download_config_module_name_key; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_cms_download_config
    ADD CONSTRAINT labgt_cms_download_config_module_name_key UNIQUE (module_name);


--
