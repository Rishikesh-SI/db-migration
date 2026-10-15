-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_user_emailid
-- Type: INDEX

-- Name: ix_yho_user_emailid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_user_emailid ON yho.yho_user USING btree (email_id);


--
