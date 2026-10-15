-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_entity_language_map_ename
-- Type: INDEX

-- Name: ix_kxp_entity_language_map_ename; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_entity_language_map_ename ON labkxp1.labkxp_entity_language_map USING btree (entity_name);


--
