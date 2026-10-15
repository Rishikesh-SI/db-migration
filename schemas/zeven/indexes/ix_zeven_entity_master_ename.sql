-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_entity_master_ename
-- Type: INDEX

-- Name: ix_zeven_entity_master_ename; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_entity_master_ename ON zeven.zeven_entity_master USING btree (entity_name);


--
