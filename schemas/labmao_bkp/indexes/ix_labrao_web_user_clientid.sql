-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: ix_labrao_web_user_clientid
-- Type: INDEX

-- Name: ix_labrao_web_user_clientid; Type: INDEX; Schema: labmao_bkp; Owner: -
--

CREATE INDEX ix_labrao_web_user_clientid ON labmao_bkp.labmao_web_user USING btree (upper_email_id, client_id);


--
