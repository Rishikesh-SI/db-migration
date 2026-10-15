-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_entity_master_ename
-- Type: INDEX

-- Name: ix_tfa_entity_master_ename; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_entity_master_ename ON tfa.tfa_entity_master USING btree (entity_name);


--
