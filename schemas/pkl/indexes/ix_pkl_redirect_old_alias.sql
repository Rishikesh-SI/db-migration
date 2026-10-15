-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: ix_pkl_redirect_old_alias
-- Type: INDEX

-- Name: ix_pkl_redirect_old_alias; Type: INDEX; Schema: pkl; Owner: -
--

CREATE UNIQUE INDEX ix_pkl_redirect_old_alias ON pkl.pkl_redirect USING btree (old_alias);


--
