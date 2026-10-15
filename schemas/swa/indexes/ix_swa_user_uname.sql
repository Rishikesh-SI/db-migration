-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_swa_user_uname
-- Type: INDEX

-- Name: ix_swa_user_uname; Type: INDEX; Schema: swa; Owner: -
--

CREATE UNIQUE INDEX ix_swa_user_uname ON swa.swa_user USING btree (user_name);


--
