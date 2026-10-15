-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_web_user_clientid
-- Type: INDEX

-- Name: ix_yho_web_user_clientid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_web_user_clientid ON yho.yho_web_user USING btree (upper_email_id, client_id);


--
