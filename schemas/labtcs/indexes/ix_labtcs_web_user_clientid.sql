-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_labtcs_web_user_clientid
-- Type: INDEX

-- Name: ix_labtcs_web_user_clientid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_labtcs_web_user_clientid ON labtcs.labtcs_web_user USING btree (upper_email_id, client_id);


--
