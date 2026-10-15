-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_user_emailid
-- Type: INDEX

-- Name: ix_zeven_user_emailid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_user_emailid ON zeven.zeven_user USING btree (email_id);


--
