-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_master_ename
-- Type: INDEX

-- Name: ix_abp_entity_master_ename; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_master_ename ON abpp.abp_entity_master USING btree (entity_name);


--
