-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: ix_dd_user_emailid
-- Type: INDEX

-- Name: ix_dd_user_emailid; Type: INDEX; Schema: dd_30_04_24; Owner: -
--

CREATE INDEX ix_dd_user_emailid ON dd_30_04_24.dd_user USING btree (email_id);


--
