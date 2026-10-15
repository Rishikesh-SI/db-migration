-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_name_version_number
-- Type: INDEX

-- Name: waf_client_name_version_number; Type: INDEX; Schema: waf_master; Owner: -
--

CREATE INDEX waf_client_name_version_number ON waf_master.waf_client_draft USING btree (client_prefix, version_number);


--
