-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: ix_upy_entity_master_ename
-- Type: INDEX

-- Name: ix_upy_entity_master_ename; Type: INDEX; Schema: upy; Owner: -
--

CREATE INDEX ix_upy_entity_master_ename ON upy.upy_entity_master USING btree (entity_name);


--
