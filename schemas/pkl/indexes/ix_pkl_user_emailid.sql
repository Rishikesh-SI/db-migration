-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_user_emailid
-- Type: INDEX

-- Name: ix_pkl_user_emailid; Type: INDEX; Schema: pkl; Owner: -
--

CREATE INDEX ix_pkl_user_emailid ON pkl.pkl_user USING btree (email_id);


--
