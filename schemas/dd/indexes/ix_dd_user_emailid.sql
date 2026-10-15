-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_user_emailid
-- Type: INDEX

-- Name: ix_dd_user_emailid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_user_emailid ON dd.dd_user USING btree (email_id);


--
