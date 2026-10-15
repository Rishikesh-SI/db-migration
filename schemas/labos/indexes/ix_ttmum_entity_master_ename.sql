-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labos; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labos.labos_entity_master USING btree (entity_name);


--
