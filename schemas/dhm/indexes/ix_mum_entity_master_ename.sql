-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: ix_mum_entity_master_ename
-- Type: INDEX

-- Name: ix_mum_entity_master_ename; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX ix_mum_entity_master_ename ON dhm.dhm_entity_master USING btree (entity_name);


--
