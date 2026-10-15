-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_web_user_upper_email_id_client_id_idx
-- Type: INDEX

-- Name: upstox_web_user_upper_email_id_client_id_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE INDEX upstox_web_user_upper_email_id_client_id_idx ON labupstox.labupstox_web_user USING btree (upper_email_id, client_id);


--
