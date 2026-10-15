-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labrao.labrao_entity_master USING btree (entity_name);


--
