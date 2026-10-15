-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labstmp.labstmp_entity_master USING btree (entity_name);


--
