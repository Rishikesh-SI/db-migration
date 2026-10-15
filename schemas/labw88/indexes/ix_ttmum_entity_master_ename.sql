-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_entity_master_ename
-- Type: INDEX

-- Name: ix_ttmum_entity_master_ename; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_entity_master_ename ON labw88.labw88_entity_master USING btree (entity_name);


--
