-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_user_role_rid
-- Type: INDEX

-- Name: ix_pkl_user_role_rid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_user_role_rid ON pkl.pkl_user_role USING btree (role_id);


--
