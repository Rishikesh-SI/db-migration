-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: ix_ttmum_entity_image_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_image_map_ename; Type: INDEX; Schema: labmi_beta_22042024; Owner: -
--

CREATE INDEX ix_ttmum_entity_image_map_ename ON labmi_beta_22042024.labmi_entity_image_map USING btree (entity_master_id);


--
