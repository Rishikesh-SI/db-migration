-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: upstox_web_user_user_guid_idx
-- Type: INDEX

-- Name: upstox_web_user_user_guid_idx; Type: INDEX; Schema: labupstox; Owner: -
--

CREATE UNIQUE INDEX upstox_web_user_user_guid_idx ON labupstox.labupstox_web_user USING btree (user_guid);


--
