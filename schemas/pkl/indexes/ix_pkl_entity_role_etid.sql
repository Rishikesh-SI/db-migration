-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_entity_role_etid
-- Type: INDEX

-- Name: ix_pkl_entity_role_etid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_entity_role_etid ON pkl.pkl_entity_role USING btree (entity_type_id);


--
