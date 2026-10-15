-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: ix_labrao_web_user_clientid
-- Type: INDEX

-- Name: ix_labrao_web_user_clientid; Type: INDEX; Schema: labrao; Owner: -
--

CREATE INDEX ix_labrao_web_user_clientid ON labrao.labrao_web_user USING btree (upper_email_id, client_id);


--
