-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: cli_stp_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON cli_stp_v1.cli_stp_v1_entity_image_map USING btree (entity_master_id);


--
