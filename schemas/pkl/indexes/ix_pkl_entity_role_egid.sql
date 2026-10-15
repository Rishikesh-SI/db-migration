-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_entity_role_egid
-- Type: INDEX

-- Name: ix_pkl_entity_role_egid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_entity_role_egid ON pkl.pkl_entity_role USING btree (entity_group_id);


--
