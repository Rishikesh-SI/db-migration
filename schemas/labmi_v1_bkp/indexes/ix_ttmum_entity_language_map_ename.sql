-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: ix_ttmum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_language_map_ename; Type: INDEX; Schema: labmi_v1_bkp; Owner: -
--

CREATE INDEX ix_ttmum_entity_language_map_ename ON labmi_v1_bkp.labmi_v1_entity_language_map USING btree (entity_name);


--
