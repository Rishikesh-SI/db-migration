-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labpvl.labpvl_entity_master USING btree (entity_name);


--
