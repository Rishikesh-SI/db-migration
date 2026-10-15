-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labets.labets_entity_master USING btree (entity_name);


--
