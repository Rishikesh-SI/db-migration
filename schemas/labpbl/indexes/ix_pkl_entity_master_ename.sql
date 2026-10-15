-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: ix_pkl_entity_master_ename
-- Type: INDEX

-- Name: ix_pkl_entity_master_ename; Type: INDEX; Schema: labpbl; Owner: -
--

CREATE INDEX ix_pkl_entity_master_ename ON labpbl.labpbl_entity_master USING btree (entity_name);


--
