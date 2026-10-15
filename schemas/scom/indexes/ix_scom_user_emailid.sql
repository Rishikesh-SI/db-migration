-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_user_emailid
-- Type: INDEX

-- Name: ix_scom_user_emailid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_user_emailid ON scom.scom_user USING btree (email_id);


--
