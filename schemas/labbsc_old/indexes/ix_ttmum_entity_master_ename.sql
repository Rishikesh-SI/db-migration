-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labbsc_old; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labbsc_old.labbsc_entity_master USING btree (entity_name);


--
