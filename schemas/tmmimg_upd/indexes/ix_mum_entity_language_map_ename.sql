-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: ix_mum_entity_language_map_ename
-- Type: INDEX

-- Name: ix_mum_entity_language_map_ename; Type: INDEX; Schema: tmmimg_upd; Owner: -
--

CREATE INDEX ix_mum_entity_language_map_ename ON tmmimg_upd.tmmimg_upd_entity_language_map USING btree (entity_name);


--
