-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_user_uname
-- Type: INDEX

-- Name: ix_pkl_user_uname; Type: INDEX; Schema: pkl; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_user_uname ON pkl.pkl_user USING btree (user_name);


--
