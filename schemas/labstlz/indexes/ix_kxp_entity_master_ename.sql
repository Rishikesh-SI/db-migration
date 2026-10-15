-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_entity_master_ename
-- Type: INDEX

-- Name: ix_kxp_entity_master_ename; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_entity_master_ename ON labstlz.labstlz_entity_master USING btree (entity_name);


--
