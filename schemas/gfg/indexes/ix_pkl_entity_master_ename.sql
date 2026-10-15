-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_entity_master_ename
-- Type: INDEX

-- Name: ix_pkl_entity_master_ename; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_entity_master_ename ON gfg.gfg_entity_master USING btree (entity_name);


--
