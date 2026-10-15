-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_user_emailid
-- Type: INDEX

-- Name: ix_pkl_user_emailid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_user_emailid ON gfg.gfg_user USING btree (email_id);


--
