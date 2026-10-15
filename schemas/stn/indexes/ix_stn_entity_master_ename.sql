-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_entity_master_ename
-- Type: INDEX

-- Name: ix_stn_entity_master_ename; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_entity_master_ename ON stn.stn_entity_master USING btree (entity_name);


--
