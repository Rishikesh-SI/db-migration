-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_entity_role_egid
-- Type: INDEX

-- Name: ix_pkl_entity_role_egid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_entity_role_egid ON gfg.gfg_entity_role USING btree (entity_group_id);


--
